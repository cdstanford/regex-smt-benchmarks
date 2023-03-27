;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\([0]\d{1}\))(\d{7}$)|(^\([0][2]\d{1}\))(\d{6,8}$)|([0][8][0][0])([\s])(\d{5,8}$)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\"0800\u00A011273"
(define-fun Witness1 () String (str.++ "\u{22}" (str.++ "0" (str.++ "8" (str.++ "0" (str.++ "0" (str.++ "\u{a0}" (str.++ "1" (str.++ "1" (str.++ "2" (str.++ "7" (str.++ "3" ""))))))))))))
;witness2: "(06)8889808"
(define-fun Witness2 () String (str.++ "(" (str.++ "0" (str.++ "6" (str.++ ")" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "8" ""))))))))))))

(assert (= regexA (re.union (re.++ (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "(" (str.++ "0" "")))(re.++ (re.range "0" "9") (re.range ")" ")")))) (re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re "")))(re.union (re.++ (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "(" (str.++ "0" (str.++ "2" ""))))(re.++ (re.range "0" "9") (re.range ")" ")")))) (re.++ ((_ re.loop 6 8) (re.range "0" "9")) (str.to_re ""))) (re.++ (str.to_re (str.++ "0" (str.++ "8" (str.++ "0" (str.++ "0" "")))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) (re.++ ((_ re.loop 5 8) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
