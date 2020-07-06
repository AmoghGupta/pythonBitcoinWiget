#!/usr/bin/env python3
from kivy.app import App
from kivy.uix.label import Label
from kivy.clock import Clock
import requests
import json


class BitcoinPriceTicker(Label):
    def update(self, *args):
        response = requests.get('https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT')
        jsonresp1=json.loads(response.text)
        LATEST_PRICE= jsonresp1['symbol']+': '+jsonresp1['price']

        response2 = requests.get('https://api.binance.com/api/v3/ticker/price?symbol=VETBTC')
        jsonresp2=json.loads(response2.text)
        LATEST_PRICE= LATEST_PRICE + '\n\n\n'+ jsonresp2['symbol']+': '+jsonresp2['price']
        self.text = LATEST_PRICE

class BitcoinWidget(App):
    def build(self):
        ticker = BitcoinPriceTicker()
        Clock.schedule_interval(ticker.update, 1)
        
        return ticker

if __name__ == "__main__":
    BitcoinWidget().run()