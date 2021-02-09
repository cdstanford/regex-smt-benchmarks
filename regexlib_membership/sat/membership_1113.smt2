;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]+((\s|\-|\')[a-zA-Z]+)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "l"
(define-fun Witness1 () String (seq.++ "l" ""))
;witness2: "I\xDd"
(define-fun Witness2 () String (seq.++ "I" (seq.++ "\x0d" (seq.++ "d" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "'" "'")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) (re.+ (re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
