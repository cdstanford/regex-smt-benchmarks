;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^<\!\-\-(.*)+(\/){0,1}\-\->$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "<!--Z.-\x7\u00E3-->"
(define-fun Witness1 () String (seq.++ "<" (seq.++ "!" (seq.++ "-" (seq.++ "-" (seq.++ "Z" (seq.++ "." (seq.++ "-" (seq.++ "\x07" (seq.++ "\xe3" (seq.++ "-" (seq.++ "-" (seq.++ ">" "")))))))))))))
;witness2: "<!--/-->"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "!" (seq.++ "-" (seq.++ "-" (seq.++ "/" (seq.++ "-" (seq.++ "-" (seq.++ ">" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "<" (seq.++ "!" (seq.++ "-" (seq.++ "-" "")))))(re.++ (re.+ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))(re.++ (re.opt (re.range "/" "/"))(re.++ (str.to_re (seq.++ "-" (seq.++ "-" (seq.++ ">" "")))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
