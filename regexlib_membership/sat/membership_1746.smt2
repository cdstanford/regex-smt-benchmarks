;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\(\d{1,2}(\s\d{1,2}){1,2}\)\s(\d{1,2}(\s\d{1,2}){1,2})((-(\d{1,4})){0,1})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(01\u008599)\u008529\u00859\u00858-8"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "0" (seq.++ "1" (seq.++ "\x85" (seq.++ "9" (seq.++ "9" (seq.++ ")" (seq.++ "\x85" (seq.++ "2" (seq.++ "9" (seq.++ "\x85" (seq.++ "9" (seq.++ "\x85" (seq.++ "8" (seq.++ "-" (seq.++ "8" "")))))))))))))))))
;witness2: "(97\u00851\u00853)\u00A00\u00A09 9-099"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "9" (seq.++ "7" (seq.++ "\x85" (seq.++ "1" (seq.++ "\x85" (seq.++ "3" (seq.++ ")" (seq.++ "\xa0" (seq.++ "0" (seq.++ "\xa0" (seq.++ "9" (seq.++ " " (seq.++ "9" (seq.++ "-" (seq.++ "0" (seq.++ "9" (seq.++ "9" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "(" "(")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ ((_ re.loop 1 2) (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) ((_ re.loop 1 2) (re.range "0" "9"))))(re.++ (re.range ")" ")")(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.++ ((_ re.loop 1 2) (re.range "0" "9")) ((_ re.loop 1 2) (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) ((_ re.loop 1 2) (re.range "0" "9")))))(re.++ (re.opt (re.++ (re.range "-" "-") ((_ re.loop 1 4) (re.range "0" "9")))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
