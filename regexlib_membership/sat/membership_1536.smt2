;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Za-zÀ-ÖØ-öø-ÿ '\-\.]{1,22}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00F6\u00C9 \u00D6O"
(define-fun Witness1 () String (str.++ "\u{f6}" (str.++ "\u{c9}" (str.++ " " (str.++ "\u{d6}" (str.++ "O" ""))))))
;witness2: "\u00D6k"
(define-fun Witness2 () String (str.++ "\u{d6}" (str.++ "k" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 22) (re.union (re.range " " " ")(re.union (re.range "'" "'")(re.union (re.range "-" ".")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
