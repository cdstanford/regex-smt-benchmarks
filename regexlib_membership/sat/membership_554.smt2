;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\+)?([-\._\(\) ]?[\d]{3,20}[-\._\(\) ]?){2,10}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "#+9891__3489106"
(define-fun Witness1 () String (seq.++ "#" (seq.++ "+" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "1" (seq.++ "_" (seq.++ "_" (seq.++ "3" (seq.++ "4" (seq.++ "8" (seq.++ "9" (seq.++ "1" (seq.++ "0" (seq.++ "6" ""))))))))))))))))
;witness2: "\u00A6x+ 926 288\u00D3"
(define-fun Witness2 () String (seq.++ "\xa6" (seq.++ "x" (seq.++ "+" (seq.++ " " (seq.++ "9" (seq.++ "2" (seq.++ "6" (seq.++ " " (seq.++ "2" (seq.++ "8" (seq.++ "8" (seq.++ "\xd3" "")))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "+" "+")) ((_ re.loop 2 10) (re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "-" ".") (re.range "_" "_")))))(re.++ ((_ re.loop 3 20) (re.range "0" "9")) (re.opt (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "-" ".") (re.range "_" "_")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
