#
# Contents:
#   sin(x, prec)
#   cos(x, prec)
#   exp(x, prec)
#   log(x, prec)
#   PI (prec)
#
# where:
#   x    ... BigDecimal number to be computed.
#   prec ... Number of digits to be obtained.
#
module BigMath
  def sin(x, prec)
    raise ArgumentError, "Zero or negative precision for sin" if prec <= 0
    return BigDecimal("NaN") if x.infinite? || x.nan?
    n    = prec + BigDecimal.double_fig
    n2   = n+n
    one  = BigDecimal("1")
    two  = BigDecimal("2")
    x1   = x
    x2   = x * x
    sign = 1
    y    = x
    d    = y
    i    = one
    z    = one
    while d.nonzero? && ((m = n - (y.exponent - d.exponent).abs) > 0)
      m = BigDecimal.double_fig if m < BigDecimal.double_fig
      sign = -sign
      x1  = x2.mult(x1,n2)
      i  += two
      z  *= (i-one) * i
      d   = sign * x1.div(z,m)
      y  += d
    end
    y
  end

  def cos(x, prec)
    raise ArgumentError, "Zero or negative precision for sin" if prec <= 0
    return BigDecimal("NaN") if x.infinite? || x.nan?
    n    = prec + BigDecimal.double_fig
    n2   = n+n
    one  = BigDecimal("1")
    two  = BigDecimal("2")
    x1 = one
    x2 = x * x
    sign = 1
    y = one
    d = y
    i = BigDecimal("0")
    z = one
    while d.nonzero? && ((m = n - (y.exponent - d.exponent).abs) > 0)
      m = BigDecimal.double_fig if m < BigDecimal.double_fig
      sign = -sign
      x1  = x2.mult(x1,n2)
      i  += two
      z  *= (i-one) * i
      d   = sign * x1.div(z,m)
      y  += d
    end
    y
  end

  def exp(x, prec)
    raise ArgumentError, "Zero or negative precision for sin" if prec <= 0
    return BigDecimal("NaN") if x.infinite? || x.nan?
    n    = prec + BigDecimal.double_fig
    n2   = n+n
    one  = BigDecimal("1")
    x1 = one
    y  = one
    d  = y
    z  = one
    i  = 0
    while d.nonzero? && ((m = n - (y.exponent - d.exponent).abs) > 0)
      m = BigDecimal.double_fig if m < BigDecimal.double_fig
      x1  = x1.mult(x,n2)
      i += 1
      z *= i
      d  = x1.div(z,m)
      y += d
    end
    y
  end

  def log(x, prec)
    raise ArgumentError, "Zero or negative argument for log" if x <= 0 || prec <= 0
    return x if x.infinite? || x.nan?
    one = BigDecimal("1")
    two = BigDecimal("2")
    n  = prec + BigDecimal.double_fig
    n2 = n + n
    x  = (x - one).div(x + one,n)
    x2 = x   * x
    y  = two * x
    d  = y
    i = one
    while d.nonzero? && ((m = n - (y.exponent - d.exponent).abs) > 0)
      m = BigDecimal.double_fig if m < BigDecimal.double_fig
      x  = x2.mult(x,n2)
      i += two
      d  = (two * x).div(i,m)
      y += d
    end
    y
  end

  def PI(prec)
    raise ArgumentError, "Zero or negative argument for PI" if prec <= 0
    n      = prec + BigDecimal.double_fig
    zero   = BigDecimal("0")
    one    = BigDecimal("1")
    two    = BigDecimal("2")

    m25    = BigDecimal("-0.04")
    m57121 = BigDecimal("-57121")

    pi     = zero

    d = one
    k = one
    w = one
    t = BigDecimal("-80")
    while d.nonzero? && ((m = n - (pi.exponent - d.exponent).abs) > 0)
      m = BigDecimal.double_fig if m < BigDecimal.double_fig
      t   = t*m25
      d   = t.div(k,m)
      k   = k+two
      pi  = pi + d
    end

    d = one
    k = one
    w = one
    t = BigDecimal("956")
    while d.nonzero? && ((m = n - (pi.exponent - d.exponent).abs) > 0)
      m = BigDecimal.double_fig if m < BigDecimal.double_fig
      t   = t.div(m57121,m)
      d   = t.div(k,m)
      pi  = pi + d
      k   = k+two
    end
    pi
  end
end