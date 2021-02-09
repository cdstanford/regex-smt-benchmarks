;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+?36)?[ -]?(\d{1,2}|(\(\d{1,2}\)))/?([ -]?\d){6,7}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "88/-9 68 3 26"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "8" (seq.++ "/" (seq.++ "-" (seq.++ "9" (seq.++ " " (seq.++ "6" (seq.++ "8" (seq.++ " " (seq.++ "3" (seq.++ " " (seq.++ "2" (seq.++ "6" ""))))))))))))))
;witness2: "+3608/970-9 36 8"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "3" (seq.++ "6" (seq.++ "0" (seq.++ "8" (seq.++ "/" (seq.++ "9" (seq.++ "7" (seq.++ "0" (seq.++ "-" (seq.++ "9" (seq.++ " " (seq.++ "3" (seq.++ "6" (seq.++ " " (seq.++ "8" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.opt (re.range "+" "+")) (str.to_re (seq.++ "3" (seq.++ "6" "")))))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-")))(re.++ (re.union ((_ re.loop 1 2) (re.range "0" "9")) (re.++ (re.range "(" "(")(re.++ ((_ re.loop 1 2) (re.range "0" "9")) (re.range ")" ")"))))(re.++ (re.opt (re.range "/" "/"))(re.++ ((_ re.loop 6 7) (re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) (re.range "0" "9"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
