# -*- conding:utf-8 -*-

import pygame

from settings import Settings
from ship import Ship
import game_functions as gf
from pygame.sprite import Group


def run_game():
    pygame.init()
    ai_settings = Settings()
    screen = pygame.display.set_mode(
        (ai_settings.screen_width, ai_settings.screen_height))
    pygame.display.set_caption('Alien Invasion')

    ship = Ship(ai_settings, screen)
    # 创建一个用于存储子弹的编组
    bullets = Group()

    while True:
        # 监视键盘和鼠标事件
        gf.check_events(ai_settings, screen, ship, bullets)
        ship.update()
        gf.update_bullets(bullets)

        # 每次循环时重新绘制屏幕
        gf.update_screen(ai_settings, screen, ship, bullets)

        # 让最近绘制的屏幕可见
        pygame.display.flip()


run_game()
