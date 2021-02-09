;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+?)(\d{2,4})(\s?)(\-?)((\(0\))?)(\s?)(\d{2})(\s?)(\-?)(\d{3})(\s?)(\-?)(\d{2})(\s?)(\-?)(\d{2})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "2899(0)\xD53-894-1909\u00E4"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "(" (seq.++ "0" (seq.++ ")" (seq.++ "\x0d" (seq.++ "5" (seq.++ "3" (seq.++ "-" (seq.++ "8" (seq.++ "9" (seq.++ "4" (seq.++ "-" (seq.++ "1" (seq.++ "9" (seq.++ "0" (seq.++ "9" (seq.++ "\xe4" "")))))))))))))))))))))
;witness2: "+93\xD(0)\x984\x9-848\xD9986"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "9" (seq.++ "3" (seq.++ "\x0d" (seq.++ "(" (seq.++ "0" (seq.++ ")" (seq.++ "\x09" (seq.++ "8" (seq.++ "4" (seq.++ "\x09" (seq.++ "-" (seq.++ "8" (seq.++ "4" (seq.++ "8" (seq.++ "\x0d" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "6" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "+" "+"))(re.++ ((_ re.loop 2 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (str.to_re (seq.++ "(" (seq.++ "0" (seq.++ ")" "")))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 2 2) (re.range "0" "9"))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
