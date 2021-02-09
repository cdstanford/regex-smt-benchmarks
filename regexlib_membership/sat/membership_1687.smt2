;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\{|\[|\().+(\}|\]|\)).+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(\u008F)\u00A5\u009B\u00F3\u00DB"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "\x8f" (seq.++ ")" (seq.++ "\xa5" (seq.++ "\x9b" (seq.++ "\xf3" (seq.++ "\xdb" ""))))))))
;witness2: "{ )\u0093\x17"
(define-fun Witness2 () String (seq.++ "{" (seq.++ " " (seq.++ ")" (seq.++ "\x93" (seq.++ "\x17" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "(" "(")(re.union (re.range "[" "[") (re.range "{" "{")))(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.union (re.range ")" ")")(re.union (re.range "]" "]") (re.range "}" "}")))(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
