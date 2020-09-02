# -*- conding:utf-8 -*-

import pygame

from settings import Settings
from ship import Ship
import game_functions as gf


def run_game():
    pygame.init()
    ai_settings = Settings()
    screen = pygame.display.set_mode(
        (ai_settings.screen_width, ai_settings.screen_height))
    pygame.display.set_caption('Alien Invasion')

    ship = Ship(screen)

    while True:
        # 监视键盘和鼠标事件
        gf.check_events(ship)
        ship.update()

        # 每次循环时重新绘制屏幕
        gf.update_screen(ai_settings, screen, ship)

        # 让最近绘制的屏幕可见
        pygame.display.flip()


run_game()
