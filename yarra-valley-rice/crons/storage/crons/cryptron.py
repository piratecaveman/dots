import argparse
import os
import pathlib
import subprocess
import logging


log_file_parent = pathlib.Path.home() / '.cache'
log_file = log_file_parent / 'cryptron.log'
if not log_file_parent.exists():
    log_file_parent.mkdir(parents=True)

logger = logging.getLogger('cryptron')
logger.setLevel(logging.INFO)
handler = logging.FileHandler(filename=str(log_file.absolute()), mode='w')
handler.setLevel(logging.INFO)
formatter = logging.Formatter(
    '[%(levelname)s]:%(name)s:%(funcName)s:Line-%(lineno)s:%(asctime)s:%(message)s'
)
handler.setFormatter(formatter)
logger.addHandler(handler)


def make_timestamp(destination: str):
    _destination = pathlib.Path(destination) / 'timestamp'
    _destination.touch()
    return

def encrypt(
        file: str,
        destination: str,
        recipients: list,
        passphrase_file: str = 'None',
        extension: str = 'asc',
        force: bool = False):

    _file = pathlib.Path(file)
    _destination = pathlib.Path(destination)
    _recipients = ' '.join((f'--recipient {x}' for x in recipients))
    _passphrase_file = pathlib.Path(passphrase_file)
    interactive = False if _passphrase_file.exists() else True
    output = _destination / '.'.join((_file.name, extension))

    if not _file.exists():
        logger.error(f"{_file.absolute()} does not exist")
        exit(1)

    if not _destination.exists():
        _destination.mkdir(parents=True)
    elif not _destination.is_dir():
        logger.error(f"Destination [{_destination.absolute()}] should be a directory not a file")
        exit(1)

    if interactive:
        logger.info("Interactive mode selected")
        command = [
            'gpg',
            '--interactive',
            '--encrypt',
            '--sign',
            '--armor',
            f'{_recipients}',
            '--output',
            f'{output.absolute()}',
            f'{_file.absolute()}'
        ]
    else:
        command = [
            'gpg',
            '--pinentry-mode',
            'loopback',
            '--encrypt',
            '--sign',
            '--armor',
            f'{_recipients}',
            '--batch',
            '--yes',
            '--passphrase-file',
            f'{_passphrase_file.absolute()}',
            '--output',
            f'{output.absolute()}',
            f'{_file.absolute()}'
        ]

    logger.info(f"Command: {' '.join(command)}")
    if not force:
        logger.info("Not using force")
        if output.exists():
            logger.info("Output exists, checking if it is older than current input file")
            mt_source = os.stat(str(_file.absolute())).st_mtime
            mt_destination = os.stat(str(output.absolute())).st_mtime
            if mt_source < mt_destination:
                logger.info(f"{output.absolute()} is already encrypted and up to date use --force to overwrite")
                return
            else:
                logger.info(f"updating {output.absolute()}")

    command = ' '.join(command).split(' ')
    logger.info(f"Encrypting {_file.name}")
    process = subprocess.run(command, capture_output=True)
    logger.info(f'stdout: {process.stdout.decode("utf-8")}')
    logger.info(f'stderr: {process.stderr.decode("utf-8")}')
    return


def encrypt_dir(
        source: str,
        destination: str,
        recipients: list,
        passphrase_file: str = 'None',
        extension: str = 'asc',
        force: bool = False):

    _source = pathlib.Path(source)
    _destination = pathlib.Path(destination)
    _passphrase_file = pathlib.Path(passphrase_file)
    _extension = extension

    for item in _source.iterdir():
        if item.is_dir():
            encrypt_dir(
                source=str(item.absolute()),
                destination=str((_destination / item.stem).absolute()),
                recipients=recipients,
                passphrase_file=passphrase_file,
                extension=extension,
                force=force
            )
        elif item.is_file():
            encrypt(
                file=str(item.absolute()),
                destination=str(_destination.absolute()),
                recipients=recipients,
                passphrase_file=passphrase_file,
                extension=extension,
                force=force
            )

    make_timestamp(str(_destination.absolute()))
    return


def decrypt(
        file: str,
        destination: str,
        passphrase_file: str = 'None'):

    _file = pathlib.Path(file)
    _destination = pathlib.Path(destination)
    _passphrase_file = pathlib.Path(passphrase_file)
    interactive = False if _passphrase_file.exists() else True
    output = _destination / _file.stem

    if not _file.exists():
        logger.error(f"{_file.absolute()} does not exist")
        exit(1)

    if not _destination.exists():
        logger.warning(f"{_destination.absolute()} does not exist")
        logger.info(f"creating {_destination.absolute()}")
        _destination.mkdir(parents=True)
    elif _destination.is_file():
        logger.error(f"Destination [{_destination.absolute()}] should be a directory not a file")
        exit(1)

    if interactive:
        command = [
            'gpg',
            '--interactive',
            '--decrypt',
            '--output',
            f'{output.absolute()}',
            f'{_file.absolute()}'
        ]
    else:
        command = [
            'gpg',
            '--pinentry-mode',
            'loopback',
            '--decrypt',
            '--batch',
            '--yes',
            '--passphrase-file',
            f'{_passphrase_file.absolute()}',
            '--output',
            f'{output.absolute()}',
            f'{_file.absolute()}'
        ]

    logger.info(f"Command: {' '.join(command)}")
    command = ' '.join(command).split(' ')
    logger.info(f"Decrypting {_file.name}")
    process = subprocess.run(command, capture_output=True)
    logger.info(f'stdout: {process.stdout.decode("utf-8")}')
    logger.info(f'stderr: {process.stderr.decode("utf-8")}')
    return


def decrypt_dir(source: str, destination: str, passphrase_file: str = 'None'):
    _source = pathlib.Path(source)
    _destination = pathlib.Path(destination)

    if not _source.exists():
        logger.error(f"{_source.absolute()} does not exist")
        exit(1)

    if not _destination.exists():
        logger.warning(f"{_destination.absolute()} does not exist")
        logger.info(f"creating {_destination.absolute()}")
        _destination.mkdir(parents=True)
    elif _destination.is_file():
        logger.error(f"Destination [{_destination.absolute()}] should be a directory not a file")
        exit(1)

    for item in _source.iterdir():
        if item.is_dir():
            decrypt_dir(
                source=str(item.absolute()),
                destination=str((_destination / item.stem).absolute()),
                passphrase_file=passphrase_file
            )
        else:
            decrypt(
                file=str(item.absolute()),
                destination=str(_destination.absolute()),
                passphrase_file=passphrase_file
            )
    return


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--operation',
        '-o',
        action='store',
        dest='operation',
        default=None,
        type=str,
        help="Usage: [-O | --operation] [encrypt | decrypt]"
    )
    parser.add_argument(
        '--source',
        '-s',
        action='store',
        dest='source',
        default=None,
        type=str,
        help="Usage: [-s | --source] /path/to/dir"
    )
    parser.add_argument(
        '--destination',
        '-d',
        action='store',
        dest='destination',
        default=None,
        type=str,
        help="Usage: [-d | --destination] /path/to/destination/dir"
    )
    parser.add_argument(
        '--recipient',
        '-r',
        action='append',
        dest='recipients',
        default=list(),
        help="Usage: [-r | --recipient] [name | ID | fingerprint]"
    )
    parser.add_argument(
        '--force',
        '-f',
        action='store_true',
        dest='force',
        default=False,
        help="Usage: [-f | --force]"
    )
    parser.add_argument(
        '--passphrase-file',
        '-p',
        action='store',
        dest='passphrase_file',
        default='None',
        type=str,
        help="Usage: [-p | --passphrase-file] /path/to/file"
    )
    parser.add_argument(
        '--extension',
        '-e',
        action='store',
        dest='extension',
        default='asc',
        type=str,
        help="Usage: [-e | --extension] name"
    )
    args = parser.parse_args()

    if args.operation is None:
        print("Operation is not specified")
        exit(1)
    elif args.operation.lower() not in ('encrypt', 'decrypt'):
        print("Only \"encrypt\" and \"decrypt\" operations are supported")
        exit(1)
    elif args.operation.lower() == 'encrypt':
        if not args.recipients:
            print("At least one recipient is required for \"encrypt\" operation")
            exit(1)
    if args.source is None:
        print("Source is not provided")
        exit(1)
    if args.destination is None:
        print("Destination is not provided")
        exit(1)

    if args.operation.lower() == 'encrypt':
        encrypt_dir(
            source=args.source,
            destination=args.destination,
            recipients=args.recipients,
            passphrase_file=args.passphrase_file,
            extension=args.extension,
            force=args.force
        )
    elif args.operation.lower() == 'decrypt':
        decrypt_dir(
            source=args.source,
            destination=args.destination,
            passphrase_file=args.passphrase_file
        )
    else:
        pass

    exit(0)
