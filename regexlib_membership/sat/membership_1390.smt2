;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [:;]{1}[-~+o]?[(&lt;\[]+
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\";[C4\u00D8"
(define-fun Witness1 () String (str.++ "\u{22}" (str.++ ";" (str.++ "[" (str.++ "C" (str.++ "4" (str.++ "\u{d8}" "")))))))
;witness2: "\x9G;t&\u00BFv"
(define-fun Witness2 () String (str.++ "\u{09}" (str.++ "G" (str.++ ";" (str.++ "t" (str.++ "&" (str.++ "\u{bf}" (str.++ "v" ""))))))))

(assert (= regexA (re.++ (re.range ":" ";")(re.++ (re.opt (re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "o" "o") (re.range "~" "~"))))) (re.+ (re.union (re.range "&" "&")(re.union (re.range "(" "(")(re.union (re.range ";" ";")(re.union (re.range "[" "[")(re.union (re.range "l" "l") (re.range "t" "t")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
