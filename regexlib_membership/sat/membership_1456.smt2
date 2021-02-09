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

;witness1: " 8584_4387(8865849(m\u0096<u6$A"
(define-fun Witness1 () String (seq.++ " " (seq.++ "8" (seq.++ "5" (seq.++ "8" (seq.++ "4" (seq.++ "_" (seq.++ "4" (seq.++ "3" (seq.++ "8" (seq.++ "7" (seq.++ "(" (seq.++ "8" (seq.++ "8" (seq.++ "6" (seq.++ "5" (seq.++ "8" (seq.++ "4" (seq.++ "9" (seq.++ "(" (seq.++ "m" (seq.++ "\x96" (seq.++ "<" (seq.++ "u" (seq.++ "6" (seq.++ "$" (seq.++ "A" "")))))))))))))))))))))))))))
;witness2: "+799807_#"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "7" (seq.++ "_" (seq.++ "#" ""))))))))))

(assert (= regexA (re.++ (re.opt (re.range "+" "+")) ((_ re.loop 2 10) (re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "-" ".") (re.range "_" "_")))))(re.++ ((_ re.loop 3 20) (re.range "0" "9")) (re.opt (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "-" ".") (re.range "_" "_")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
