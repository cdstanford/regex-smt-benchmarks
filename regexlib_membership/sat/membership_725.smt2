;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(5[1-5]\d{2})\d{12}|(4\d{3})(\d{12}|\d{9})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "5488825421826804\u00BD\u00FC\u0082"
(define-fun Witness1 () String (str.++ "5" (str.++ "4" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "2" (str.++ "5" (str.++ "4" (str.++ "2" (str.++ "1" (str.++ "8" (str.++ "2" (str.++ "6" (str.++ "8" (str.++ "0" (str.++ "4" (str.++ "\u{bd}" (str.++ "\u{fc}" (str.++ "\u{82}" ""))))))))))))))))))))
;witness2: "\x154082995843929"
(define-fun Witness2 () String (str.++ "\u{15}" (str.++ "4" (str.++ "0" (str.++ "8" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "5" (str.++ "8" (str.++ "4" (str.++ "3" (str.++ "9" (str.++ "2" (str.++ "9" "")))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.++ (re.range "5" "5")(re.++ (re.range "1" "5") ((_ re.loop 2 2) (re.range "0" "9")))) ((_ re.loop 12 12) (re.range "0" "9")))) (re.++ (re.++ (re.range "4" "4") ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.union ((_ re.loop 12 12) (re.range "0" "9")) ((_ re.loop 9 9) (re.range "0" "9"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
