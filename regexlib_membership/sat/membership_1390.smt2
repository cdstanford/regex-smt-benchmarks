;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [:;]{1}[-~+o]?[(&lt;\[]+
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\";[C4\u00D8"
(define-fun Witness1 () String (seq.++ "\x22" (seq.++ ";" (seq.++ "[" (seq.++ "C" (seq.++ "4" (seq.++ "\xd8" "")))))))
;witness2: "\x9G;t&\u00BFv"
(define-fun Witness2 () String (seq.++ "\x09" (seq.++ "G" (seq.++ ";" (seq.++ "t" (seq.++ "&" (seq.++ "\xbf" (seq.++ "v" ""))))))))

(assert (= regexA (re.++ (re.range ":" ";")(re.++ (re.opt (re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "o" "o") (re.range "~" "~"))))) (re.+ (re.union (re.range "&" "&")(re.union (re.range "(" "(")(re.union (re.range ";" ";")(re.union (re.range "[" "[")(re.union (re.range "l" "l") (re.range "t" "t")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
