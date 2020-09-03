# -*- coding:utf-8 -*-

import pygame


class Ship():

    def __init__(self, ai_settings, screen):
        # 初始化飞船及其位置
        self.screen = screen
        self.ai_settings = ai_settings

        # 加载飞船图像并获取其外接矩阵
        self.image = pygame.image.load('images/ship.bmp')
        self.rect = self.image.get_rect()
        self.screen_rect = screen.get_rect()

        # 将每艘新飞船放在屏幕底部正中央
        self.rect.centerx = self.screen_rect.centerx
        self.rect.bottom = self.screen_rect.bottom

        # 在飞船的属性 center 中存储小数点
        self.center = float(self.rect.centerx)

        # 移动标志
        self.moving_right = False
        self.moving_left = False

    def update(self):
        # 更新飞船的 center 值，而不是 rect
        if self.moving_right and self.rect.right < self.screen_rect.right:
            self.center += self.ai_settings.ship_speed_factor
        if self.moving_left and self.rect.left > 0:
            self.center -= self.ai_settings.ship_speed_factor

        # 根据 self.center 更新 rect 对象
        self.rect.centerx = self.center

    def blitme(self):
        self.screen.blit(self.image, self.rect)
