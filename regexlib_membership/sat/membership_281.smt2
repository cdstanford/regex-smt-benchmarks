;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([a-zA-Z]{2}[0-9]{1,2}\s{0,1}[0-9]{1,2}[a-zA-Z]{2})
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A7\u00D0Yb579MI\u00EF"
(define-fun Witness1 () String (str.++ "\u{a7}" (str.++ "\u{d0}" (str.++ "Y" (str.++ "b" (str.++ "5" (str.++ "7" (str.++ "9" (str.++ "M" (str.++ "I" (str.++ "\u{ef}" "")))))))))))
;witness2: "xA8799al"
(define-fun Witness2 () String (str.++ "x" (str.++ "A" (str.++ "8" (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "a" (str.++ "l" "")))))))))

(assert (= regexA (re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 1 2) (re.range "0" "9")) ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
