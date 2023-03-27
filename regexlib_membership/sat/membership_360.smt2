;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+?)(\d{2,4})(\s?)(\-?)((\(0\))?)(\s?)(\d{2})(\s?)(\-?)(\d{3})(\s?)(\-?)(\d{2})(\s?)(\-?)(\d{2})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "2899(0)\xD53-894-1909\u00E4"
(define-fun Witness1 () String (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "(" (str.++ "0" (str.++ ")" (str.++ "\u{0d}" (str.++ "5" (str.++ "3" (str.++ "-" (str.++ "8" (str.++ "9" (str.++ "4" (str.++ "-" (str.++ "1" (str.++ "9" (str.++ "0" (str.++ "9" (str.++ "\u{e4}" "")))))))))))))))))))))
;witness2: "+93\xD(0)\x984\x9-848\xD9986"
(define-fun Witness2 () String (str.++ "+" (str.++ "9" (str.++ "3" (str.++ "\u{0d}" (str.++ "(" (str.++ "0" (str.++ ")" (str.++ "\u{09}" (str.++ "8" (str.++ "4" (str.++ "\u{09}" (str.++ "-" (str.++ "8" (str.++ "4" (str.++ "8" (str.++ "\u{0d}" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "6" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "+" "+"))(re.++ ((_ re.loop 2 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (str.to_re (str.++ "(" (str.++ "0" (str.++ ")" "")))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 2 2) (re.range "0" "9"))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
