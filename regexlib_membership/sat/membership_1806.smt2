;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]+(([\'\,\.\- ][a-zA-Z ])?[a-zA-Z]*)*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "ZNyG"
(define-fun Witness1 () String (seq.++ "Z" (seq.++ "N" (seq.++ "y" (seq.++ "G" "")))))
;witness2: "vydldy\' z"
(define-fun Witness2 () String (seq.++ "v" (seq.++ "y" (seq.++ "d" (seq.++ "l" (seq.++ "d" (seq.++ "y" (seq.++ "'" (seq.++ " " (seq.++ "z" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.++ (re.opt (re.++ (re.union (re.range " " " ")(re.union (re.range "'" "'") (re.range "," "."))) (re.union (re.range " " " ")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
