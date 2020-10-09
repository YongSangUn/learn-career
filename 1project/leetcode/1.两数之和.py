#
# @lc app=leetcode.cn id=1 lang=python3
#
# [1] 两数之和
#


# @lc code=start
class Solution:

    def twoSum(self, nums: List[int], target: int) -> List[int]:
        n = len(nums)
        if n <= 1:
            return []

        for i in range(n):
            for j in range(i + 1, n):
                if nums[i] + nums[j] == target:
                    return [i, j]

        return []


# @lc code=end
