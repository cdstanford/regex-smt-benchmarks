;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\w_.]{5,12}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E0\u00F2E\u00CD\u00D4"
(define-fun Witness1 () String (str.++ "\u{e0}" (str.++ "\u{f2}" (str.++ "E" (str.++ "\u{cd}" (str.++ "\u{d4}" ""))))))
;witness2: "Ad\u00BA9\u00B5.\u00B5"
(define-fun Witness2 () String (str.++ "A" (str.++ "d" (str.++ "\u{ba}" (str.++ "9" (str.++ "\u{b5}" (str.++ "." (str.++ "\u{b5}" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 12) (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
