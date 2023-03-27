;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\+[0-9]{2}|^\+[0-9]{2}\(0\)|^\(\+[0-9]{2}\)\(0\)|^00[0-9]{2}|^0)([0-9]{9}$|[0-9\-\s]{10}$)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0\xD\xA\x98\xC\u00A03\x9\u00A0\xC"
(define-fun Witness1 () String (str.++ "0" (str.++ "\u{0d}" (str.++ "\u{0a}" (str.++ "\u{09}" (str.++ "8" (str.++ "\u{0c}" (str.++ "\u{a0}" (str.++ "3" (str.++ "\u{09}" (str.++ "\u{a0}" (str.++ "\u{0c}" ""))))))))))))
;witness2: "0074894960497"
(define-fun Witness2 () String (str.++ "0" (str.++ "0" (str.++ "7" (str.++ "4" (str.++ "8" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "6" (str.++ "0" (str.++ "4" (str.++ "9" (str.++ "7" ""))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re "")(re.++ (re.range "+" "+") ((_ re.loop 2 2) (re.range "0" "9"))))(re.union (re.++ (str.to_re "")(re.++ (re.range "+" "+")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re (str.++ "(" (str.++ "0" (str.++ ")" "")))))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "(" (str.++ "+" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re (str.++ ")" (str.++ "(" (str.++ "0" (str.++ ")" ""))))))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "0" (str.++ "0" ""))) ((_ re.loop 2 2) (re.range "0" "9")))) (re.++ (str.to_re "") (re.range "0" "0")))))) (re.union (re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re "")) (re.++ ((_ re.loop 10 10) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
