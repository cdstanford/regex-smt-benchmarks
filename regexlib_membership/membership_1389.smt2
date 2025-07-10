;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [:]{1}[-~+o]?[)&gt;]+
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ":+gt&\u0082\u0090"
(define-fun Witness1 () String (str.++ ":" (str.++ "+" (str.++ "g" (str.++ "t" (str.++ "&" (str.++ "\u{82}" (str.++ "\u{90}" ""))))))))
;witness2: "\u00B4\u00A8:t\u00C4X\u008Er\x5"
(define-fun Witness2 () String (str.++ "\u{b4}" (str.++ "\u{a8}" (str.++ ":" (str.++ "t" (str.++ "\u{c4}" (str.++ "X" (str.++ "\u{8e}" (str.++ "r" (str.++ "\u{05}" ""))))))))))

(assert (= regexA (re.++ (re.range ":" ":")(re.++ (re.opt (re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "o" "o") (re.range "~" "~"))))) (re.+ (re.union (re.range "&" "&")(re.union (re.range ")" ")")(re.union (re.range ";" ";")(re.union (re.range "g" "g") (re.range "t" "t"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
