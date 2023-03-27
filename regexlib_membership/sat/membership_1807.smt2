;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^0[78][2347][0-9]{7})
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0743889382\x1"
(define-fun Witness1 () String (str.++ "0" (str.++ "7" (str.++ "4" (str.++ "3" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "3" (str.++ "8" (str.++ "2" (str.++ "\u{01}" ""))))))))))))
;witness2: "0825559289\u00D3\u00DA\u00DF|\u00AA)"
(define-fun Witness2 () String (str.++ "0" (str.++ "8" (str.++ "2" (str.++ "5" (str.++ "5" (str.++ "5" (str.++ "9" (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "\u{d3}" (str.++ "\u{da}" (str.++ "\u{df}" (str.++ "|" (str.++ "\u{aa}" (str.++ ")" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "0" "0")(re.++ (re.range "7" "8")(re.++ (re.union (re.range "2" "4") (re.range "7" "7")) ((_ re.loop 7 7) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
