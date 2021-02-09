;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <\/?(tag1|tag2)[^>]*\/?>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x19<tag2O\u00A0\'/>"
(define-fun Witness1 () String (seq.++ "\x19" (seq.++ "<" (seq.++ "t" (seq.++ "a" (seq.++ "g" (seq.++ "2" (seq.++ "O" (seq.++ "\xa0" (seq.++ "'" (seq.++ "/" (seq.++ ">" ""))))))))))))
;witness2: "<tag1>j\u00A8\u00E5\u00A87`"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "t" (seq.++ "a" (seq.++ "g" (seq.++ "1" (seq.++ ">" (seq.++ "j" (seq.++ "\xa8" (seq.++ "\xe5" (seq.++ "\xa8" (seq.++ "7" (seq.++ "`" "")))))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.opt (re.range "/" "/"))(re.++ (re.union (str.to_re (seq.++ "t" (seq.++ "a" (seq.++ "g" (seq.++ "1" ""))))) (str.to_re (seq.++ "t" (seq.++ "a" (seq.++ "g" (seq.++ "2" ""))))))(re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff")))(re.++ (re.opt (re.range "/" "/")) (re.range ">" ">"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
