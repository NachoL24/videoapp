
# import moviepy as mpy

# def editor(video):
#     OutWidth = 640
#     OutHeight = 360
#     V = mpy.VideoFileClip(video)
#     cliplist = [V]
#     s = 0
#     for time in range(int(V.duration), 0, -1):
#         cl = mpy.TextClip(str(time),font="ArialUnicode",fontsize=50.0,color="white",bg_color="transparent",stroke_color="black",stroke_width=2.0, align='Center', size=(OutWidth, OutHeight))
#         cl = cl.set_position(("center","center")).set_duration(1.0).set_start(s)
#         s += 1
#         cliplist.append(cl)

#     V = mpy.CompositeVideoClip(cliplist)
#     V = V.resize(newsize=(OutWidth,OutHeight))

