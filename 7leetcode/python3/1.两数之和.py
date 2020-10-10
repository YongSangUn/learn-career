#
# @lc app=leetcode.cn id=1 lang=python3
#
# [1] 两数之和
#

# @lc code=start

# 穷举法
# class Solution:

#     def twoSum(self, nums, target):
#         n = len(nums)
#         if n <= 1:
#             return []

#         for i in range(n):
#             for j in range(i + 1, n):
#                 if nums[i] + nums[j] == target:
#                     return [i, j]

#         return []


# 哈希字典
class Solution:

    def twoSum(self, nums, target):
        numsDict = dict()
        for i, value in enumerate(nums):
            if target - value in numsDict:
                return [numsDict[target - value], i]
            numsDict[value] = i
        return []


# @lc code=end
