;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]{4}\s{0,2}[a-zA-z]{2}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1198\u0085Rb"
(define-fun Witness1 () String (str.++ "1" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ "\u{85}" (str.++ "R" (str.++ "b" ""))))))))
;witness2: "9896\u0085da"
(define-fun Witness2 () String (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "6" (str.++ "\u{85}" (str.++ "d" (str.++ "a" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ ((_ re.loop 0 2) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 2 2) (re.range "A" "z")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
