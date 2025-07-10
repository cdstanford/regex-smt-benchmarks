;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\+){0,1}91(\s){0,1}(\-){0,1}(\s){0,1}){0,1}9[0-9](\s){0,1}(\-){0,1}(\s){0,1}[1-9]{1}[0-9]{7}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9199  80814989"
(define-fun Witness1 () String (str.++ "9" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ " " (str.++ " " (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "1" (str.++ "4" (str.++ "9" (str.++ "8" (str.++ "9" "")))))))))))))))
;witness2: "91- 9424094692"
(define-fun Witness2 () String (str.++ "9" (str.++ "1" (str.++ "-" (str.++ " " (str.++ "9" (str.++ "4" (str.++ "2" (str.++ "4" (str.++ "0" (str.++ "9" (str.++ "4" (str.++ "6" (str.++ "9" (str.++ "2" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.opt (re.range "+" "+"))(re.++ (str.to_re (str.++ "9" (str.++ "1" "")))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-")) (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))))(re.++ (re.range "9" "9")(re.++ (re.range "0" "9")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
