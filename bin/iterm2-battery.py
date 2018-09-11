#!/usr/bin/env python3

import asyncio
from iterm2 import StatusBarComponent, Registration, run
from math import floor
import re
from subprocess import CalledProcessError, check_output

chars = [
    '▏',
    '▎',
    '▍',
    '▌',
    '▋',
    '▊',
    '▉',
    '█']
thunder = 'ϟ'
width = 5
interval = 30


async def main(connection):
    component = StatusBarComponent(
        'Battery',
        'Show battery remaining',
        'Show remaining time for battery',
        [],
        '|███▎  | 66% 2:34',
        interval)

    async def coro(knobs):
        try:
            out = check_output(
                args=['/usr/bin/pmset', '-g', 'batt']).decode('utf-8')
        except CalledProcessError as err:
            return '`pmset` cannot be executed'
        try:
            status = re.match(r'.*; (.*);', out, flags=re.S)[1]
            percent = int(re.match(r'.*?(\d+)%', out, flags=re.S)[1])
        except:
            return '🔌'
        if status == 'charging':
            mid = floor(width / 2)
            battery = mid * ' ' + thunder + (width - mid) * ' '
        elif status == 'discharging':
            unit = len(chars)
            total_char_len = len(chars) * width
            char_len = floor(total_char_len * percent / 100)
            full_len = floor(char_len / unit)
            remained = char_len % unit
            space_len = width - full_len - (0 if remained == 0 else 1)
            battery = chars[-1] * full_len
            if remained != 0:
                battery += chars[remained - 1]
            battery += ' ' * space_len
        else:
            battery = ' ' * width
        matched = re.match(r'.*?(\d+:\d+)', out, flags=re.S)
        elapsed = matched[1] if matched and matched[1] != '0:00' else ''
        return '{0} |{1}| {2:d}% {3}'.format('🔋', battery, percent, elapsed)


    await Registration.async_register_status_bar_component(
        connection, component, coro)

    future = asyncio.Future()
    await connection.async_dispatch_until_future(future)


run(main)
