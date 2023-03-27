;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [+-]?\d(\.\d+)?[Ee][+-]?\d+
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "hm\u00871.8E+41"
(define-fun Witness1 () String (str.++ "h" (str.++ "m" (str.++ "\u{87}" (str.++ "1" (str.++ "." (str.++ "8" (str.++ "E" (str.++ "+" (str.++ "4" (str.++ "1" "")))))))))))
;witness2: "\u008E-7.8E-29"
(define-fun Witness2 () String (str.++ "\u{8e}" (str.++ "-" (str.++ "7" (str.++ "." (str.++ "8" (str.++ "E" (str.++ "-" (str.++ "2" (str.++ "9" ""))))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9"))))(re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) (re.+ (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
