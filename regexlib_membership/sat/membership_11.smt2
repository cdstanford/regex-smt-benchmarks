;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (1[8,9]|20)[0-9]{2}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00CF2078\x0"
(define-fun Witness1 () String (seq.++ "\xcf" (seq.++ "2" (seq.++ "0" (seq.++ "7" (seq.++ "8" (seq.++ "\x00" "")))))))
;witness2: "t\u00F51,89\u008B\u008D\u00EA\x17\u0094\x3"
(define-fun Witness2 () String (seq.++ "t" (seq.++ "\xf5" (seq.++ "1" (seq.++ "," (seq.++ "8" (seq.++ "9" (seq.++ "\x8b" (seq.++ "\x8d" (seq.++ "\xea" (seq.++ "\x17" (seq.++ "\x94" (seq.++ "\x03" "")))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.range "1" "1") (re.union (re.range "," ",") (re.range "8" "9"))) (str.to_re (seq.++ "2" (seq.++ "0" "")))) ((_ re.loop 2 2) (re.range "0" "9")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
