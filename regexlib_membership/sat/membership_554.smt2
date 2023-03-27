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

;witness1: "#+9891__3489106"
(define-fun Witness1 () String (str.++ "#" (str.++ "+" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "1" (str.++ "_" (str.++ "_" (str.++ "3" (str.++ "4" (str.++ "8" (str.++ "9" (str.++ "1" (str.++ "0" (str.++ "6" ""))))))))))))))))
;witness2: "\u00A6x+ 926 288\u00D3"
(define-fun Witness2 () String (str.++ "\u{a6}" (str.++ "x" (str.++ "+" (str.++ " " (str.++ "9" (str.++ "2" (str.++ "6" (str.++ " " (str.++ "2" (str.++ "8" (str.++ "8" (str.++ "\u{d3}" "")))))))))))))

(assert (= regexA (re.++ (re.opt (re.range "+" "+")) ((_ re.loop 2 10) (re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "-" ".") (re.range "_" "_")))))(re.++ ((_ re.loop 3 20) (re.range "0" "9")) (re.opt (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "-" ".") (re.range "_" "_")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
