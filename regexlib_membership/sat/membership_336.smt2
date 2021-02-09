;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [+-]?\d(\.\d+)?[Ee][+-]?\d+
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "hm\u00871.8E+41"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "m" (seq.++ "\x87" (seq.++ "1" (seq.++ "." (seq.++ "8" (seq.++ "E" (seq.++ "+" (seq.++ "4" (seq.++ "1" "")))))))))))
;witness2: "\u008E-7.8E-29"
(define-fun Witness2 () String (seq.++ "\x8e" (seq.++ "-" (seq.++ "7" (seq.++ "." (seq.++ "8" (seq.++ "E" (seq.++ "-" (seq.++ "2" (seq.++ "9" ""))))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9"))))(re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) (re.+ (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
