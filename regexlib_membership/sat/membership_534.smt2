;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([1-9]{1}(\d+)?)(\.\d+)?)|([0]\.(\d+)?([1-9]{1})(\d+)?)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0.80083"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "." (seq.++ "8" (seq.++ "0" (seq.++ "0" (seq.++ "8" (seq.++ "3" ""))))))))
;witness2: "\u008E0.18789"
(define-fun Witness2 () String (seq.++ "\x8e" (seq.++ "0" (seq.++ "." (seq.++ "1" (seq.++ "8" (seq.++ "7" (seq.++ "8" (seq.++ "9" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (re.++ (re.range "1" "9") (re.opt (re.+ (re.range "0" "9")))) (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9")))))) (re.++ (re.++ (str.to_re (seq.++ "0" (seq.++ "." "")))(re.++ (re.opt (re.+ (re.range "0" "9")))(re.++ (re.range "1" "9") (re.opt (re.+ (re.range "0" "9")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
