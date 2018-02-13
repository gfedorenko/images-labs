x = 5
y = 5
xp = [0, 0, 10, 0]
yp = [0, 10, 10, 10]
def inPoly x, y, xp, yp
  n = xp.size
  j = n - 1
  c = false
  n.times do |i|
    if (((yp[i] <= y && y <yp[j]) || (yp[j] <= y && y < yp[i])) && (x > (xp[j] - xp[i]) * (y - yp[i]) / (yp[j] - yp[i]) + xp[i]))
      c = !c
    else
      j = i
    end
  end
  c
end

puts inPoly(x,y, xp, yp)
