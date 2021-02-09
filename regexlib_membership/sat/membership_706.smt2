;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d+)?-?(\d+)-(\d+)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "46-2jo \u00E8\u0089"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "6" (seq.++ "-" (seq.++ "2" (seq.++ "j" (seq.++ "o" (seq.++ " " (seq.++ "\xe8" (seq.++ "\x89" ""))))))))))
;witness2: "-349-2\xCd"
(define-fun Witness2 () String (seq.++ "-" (seq.++ "3" (seq.++ "4" (seq.++ "9" (seq.++ "-" (seq.++ "2" (seq.++ "\x0c" (seq.++ "d" "")))))))))

(assert (= regexA (re.++ (re.opt (re.+ (re.range "0" "9")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "-" "-") (re.+ (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
