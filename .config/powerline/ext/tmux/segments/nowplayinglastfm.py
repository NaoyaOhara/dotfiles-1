# -*- coding: utf-8 -*-
# vim:se fenc=utf8 noet:

from __future__ import absolute_import

from powerline.lib.threaded import KwThreadedSegment, with_docstring
from powerline.lib.url import urllib_read, urllib_urlencode

from collections import namedtuple
import json
import types

_NowPlayingKey = namedtuple('Key', 'username api_key format_string')

STATE_SYMBOLS = {
	'fallback': u'♫',
	'play': u'▶',
	'pause': u'▮▮',
	'stop': u'■',
	}

class NowPlayingLastFM(KwThreadedSegment):
	interval = 30

	@staticmethod
	def key(username, api_key, format_string=u'{state_symbol} {artist} - {title}', **kwargs):
		return _NowPlayingKey(username, api_key, format_string)

	def compute_state(self, key):
		if not key.username or not key.api_key:
			self.warn('Username and api_key are not configured')
			return None
		data = self.player(key)
		stats = {
				'state': None,
				'state_symbol': STATE_SYMBOLS['fallback'],
				'album': None,
				'artist': None,
				'title': None,
				'elapsed': None,
				'total': None,
				}
		stats.update(data)
		string = key.format_string.format(**stats)
		return string

	@staticmethod
	def render_one(string, **kwargs):
		return string

	def player(self, key):
		query_data = {
				'method': 'user.getrecenttracks',
				'format': 'json',
				'user': key.username,
				'api_key': key.api_key,
				'nowplaying': 'true',
				}
		url = 'http://ws.audioscrobbler.com/2.0/?' + \
				urllib_urlencode(query_data)
		self.warn(url)

		raw_response = urllib_read(url)
		if not raw_response:
			self.error('Failed to get response')
			return
		response = json.loads(raw_response)
		track_info = response['recenttracks']['track']
		track_info_type = type(track_info)
		if track_info_type == types.ListType:
			track = track_info[0]
			status = 'play'
		elif track_info_type == types.DictType:
			track = track_info[1]
		else:
			self.error('Invalid response')
			status = 'fallback'
			return
		return {
				'artist': track['artist']['#text'],
				'title': track['name'],
				'playing': status,
				}
now_playing = with_docstring(NowPlayingLastFM(), '')
