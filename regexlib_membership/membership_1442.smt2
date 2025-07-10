;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\+){0,1}91(\s){0,1}(\-){0,1}(\s){0,1}){0,1}98(\s){0,1}(\-){0,1}(\s){0,1}[1-9]{1}[0-9]{7}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "98-69374799"
(define-fun Witness1 () String (str.++ "9" (str.++ "8" (str.++ "-" (str.++ "6" (str.++ "9" (str.++ "3" (str.++ "7" (str.++ "4" (str.++ "7" (str.++ "9" (str.++ "9" ""))))))))))))
;witness2: "98\xC-29893886"
(define-fun Witness2 () String (str.++ "9" (str.++ "8" (str.++ "\u{0c}" (str.++ "-" (str.++ "2" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "3" (str.++ "8" (str.++ "8" (str.++ "6" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.opt (re.range "+" "+"))(re.++ (str.to_re (str.++ "9" (str.++ "1" "")))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-")) (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))))(re.++ (str.to_re (str.++ "9" (str.++ "8" "")))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
