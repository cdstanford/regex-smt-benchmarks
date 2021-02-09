;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [:]{1}[-~+o]?[)&gt;]+
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ":+gt&\u0082\u0090"
(define-fun Witness1 () String (seq.++ ":" (seq.++ "+" (seq.++ "g" (seq.++ "t" (seq.++ "&" (seq.++ "\x82" (seq.++ "\x90" ""))))))))
;witness2: "\u00B4\u00A8:t\u00C4X\u008Er\x5"
(define-fun Witness2 () String (seq.++ "\xb4" (seq.++ "\xa8" (seq.++ ":" (seq.++ "t" (seq.++ "\xc4" (seq.++ "X" (seq.++ "\x8e" (seq.++ "r" (seq.++ "\x05" ""))))))))))

(assert (= regexA (re.++ (re.range ":" ":")(re.++ (re.opt (re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "o" "o") (re.range "~" "~"))))) (re.+ (re.union (re.range "&" "&")(re.union (re.range ")" ")")(re.union (re.range ";" ";")(re.union (re.range "g" "g") (re.range "t" "t"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
