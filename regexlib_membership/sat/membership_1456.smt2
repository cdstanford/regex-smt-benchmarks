;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\+)?([-\._\(\) ]?[\d]{3,20}[-\._\(\) ]?){2,10}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: " 8584_4387(8865849(m\u0096<u6$A"
(define-fun Witness1 () String (str.++ " " (str.++ "8" (str.++ "5" (str.++ "8" (str.++ "4" (str.++ "_" (str.++ "4" (str.++ "3" (str.++ "8" (str.++ "7" (str.++ "(" (str.++ "8" (str.++ "8" (str.++ "6" (str.++ "5" (str.++ "8" (str.++ "4" (str.++ "9" (str.++ "(" (str.++ "m" (str.++ "\u{96}" (str.++ "<" (str.++ "u" (str.++ "6" (str.++ "$" (str.++ "A" "")))))))))))))))))))))))))))
;witness2: "+799807_#"
(define-fun Witness2 () String (str.++ "+" (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "7" (str.++ "_" (str.++ "#" ""))))))))))

(assert (= regexA (re.++ (re.opt (re.range "+" "+")) ((_ re.loop 2 10) (re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "-" ".") (re.range "_" "_")))))(re.++ ((_ re.loop 3 20) (re.range "0" "9")) (re.opt (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "-" ".") (re.range "_" "_")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
