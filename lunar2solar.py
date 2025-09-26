import datetime
import pandas as pd
from lunardate import LunarDate


start = datetime.date(1901, 1, 1)
end = datetime.date(2100, 12, 31)
delta = datetime.timedelta(days=1)

records = []

d = start
while d <= end:
    lunar = LunarDate.fromSolarDate(d.year, d.month, d.day)
    records.append({
        "solar_year": d.year,
        "solar_month": d.month,
        "solar_day": d.day,
        "lunar_year": lunar.year,
        "lunar_month": lunar.month,
        "lunar_day": lunar.day,
        "is_leap": int(lunar.isLeapMonth)  # 1=闰月, 0=平月
    })
    d += delta

# 转为 DataFrame
df = pd.DataFrame(records)

# 保存为 Stata .dta 文件
df.to_stata("/Users/ynbsztl/Downloads/lunar_solar_table.dta", write_index=False)

print("生成完成: lunar_solar_table.dta")