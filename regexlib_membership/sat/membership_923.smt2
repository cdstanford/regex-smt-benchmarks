;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^""\?\/\&\;\:\|\”\“\(\)\[\]\=\^\.\%\$\#\!\*\?\?\»\«\×\?]
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0097\u00E9\u00A1"
(define-fun Witness1 () String (str.++ "\u{97}" (str.++ "\u{e9}" (str.++ "\u{a1}" ""))))
;witness2: "\u00F8\u00B5"
(define-fun Witness2 () String (str.++ "\u{f8}" (str.++ "\u{b5}" "")))

(assert (= regexA (re.union (re.range "\u{00}" " ")(re.union (re.range "'" "'")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range "<" "<")(re.union (re.range ">" ">")(re.union (re.range "@" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "_" "{")(re.union (re.range "}" "\u{aa}")(re.union (re.range "\u{ac}" "\u{ba}")(re.union (re.range "\u{bc}" "\u{d6}") (re.range "\u{d8}" "\u{fe}")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
