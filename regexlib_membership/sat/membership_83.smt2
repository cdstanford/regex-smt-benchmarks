;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[-\w\s"'=/!@#%&,;:`~\.\$\^\{\[\(\|\)\]\}\*\+\?\\]*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\xB\xB"
(define-fun Witness1 () String (seq.++ "\x0b" (seq.++ "\x0b" "")))
;witness2: "\u0085"
(define-fun Witness2 () String (seq.++ "\x85" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " ";")(re.union (re.range "=" "=")(re.union (re.range "?" "~")(re.union (re.range "\x85" "\x85")(re.union (re.range "\xa0" "\xa0")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
