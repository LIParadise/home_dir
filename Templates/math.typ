#set text(size: 13pt, font: ((name: "Libertinus Serif", covers: "latin-in-cjk"), "Noto Serif CJK JP"))

#show math.sum: math.limits
#show math.product: math.limits
#show math.xor: math.limits
#show math.xor.big: math.limits
#show math.union: math.limits
#show math.union.big: math.limits
#show math.inter: math.limits
#show math.inter.big: math.limits
#show math.integral: math.limits
#show link: set text(fill: blue)
#set quote(block: true)

#import "@preview/commute:0.3.0": arr, commutative-diagram, node

#let skip_vector_marker = (
  sym.dots,
  sym.dots.h,
  sym.dots.h.c,
  sym.dots.v,
  sym.dots.up,
  sym.dots.down,
)
#let hl(content) = box(
  content,
  inset: 0.1em,
  radius: 0.2em,
  fill: gradient.linear(
    rgb("#F5AAAA"), // Soft coral red
    rgb("#FFD0A6"), // Peach orange
    rgb("#FFF0B3"), // Warm pastel yellow
    angle: 33deg,
  ),
)
#let quo(expr) = {
  set math.frac(style: "skewed")
  expr
}
#let row(expr) = {
  $cancel(#h(1em) expr #h(1em), angle: #90deg, stroke: #(dash: "dashed", paint: black.transparentize(67%)))$
}
#let col(expr) = {
  $cancel(#v(1em) expr #v(1em), angle: #0deg, stroke: #(dash: "dashed", paint: black.transparentize(67%)))$
}
#let rows(..exprs) = {
  let arr = exprs.pos().map(expr => if expr in skip_vector_marker [ #expr ] else [#row(expr)])
  math.vec(..arr)
}
#let cols(..exprs) = {
  let arr = exprs.pos().map(expr => if expr in skip_vector_marker [ #expr ] else [#col(expr)])
  math.mat(..arr)
}

#let aut = $op("Aut")$
#let endo = $op("End")$
#let ann = $op("Ann")$
#let hom = $op("Hom")$
#let subgroup = $subset.eq^"group"$
#let subideal = $subset.eq^"ideal"$
#let submodule = $subset.eq^"module"$
#let subring = $subset.eq^"ring"$
#let inj = $arrow.r.hook$
#let surj = $arrow.r.twohead$
#let iso = $arrow.r.tilde$
#let where = $mid(|)$
#let diag = $op("diag")$

#let ind = $bb(1)$
#let lr = $op("LR")$
#let llr = $op("LLR")$
#let lrt = $"LRT"$
#let pr = $op("Pr")$
#let given = $mid(|)$
#let vs = $mid(bar.v.double)$
