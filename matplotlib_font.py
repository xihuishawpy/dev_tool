from matplotlib.font_manager import FontProperties
from matplotlib import pyplot as plt
import sys

if sys.platform == 'linux':
    font_path = '/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc'
    my_font = FontProperties(fname=font_path)   
elif sys.platform == 'win32':
    font_path = 'C:/Windows/Fonts/simhei.ttf'
    my_font = FontProperties(fname=font_path)
elif sys.platform == 'darwin':
    font_path = '/Library/Fonts/Supplemental/SimHei.ttf'
    my_font = FontProperties(fname=font_path) 

plt.rcParams['axes.unicode_minus'] = False
plt.rcParams['font.sans-serif'] = [my_font.get_name()]