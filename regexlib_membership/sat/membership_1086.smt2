;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-z\.]*\s?([a-z\-\']+\s)+[a-z\-\']+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "-\x9z"
(define-fun Witness1 () String (seq.++ "-" (seq.++ "\x09" (seq.++ "z" ""))))
;witness2: " x v-\'-\x9x\xD----"
(define-fun Witness2 () String (seq.++ " " (seq.++ "x" (seq.++ " " (seq.++ "v" (seq.++ "-" (seq.++ "'" (seq.++ "-" (seq.++ "\x09" (seq.++ "x" (seq.++ "\x0d" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "." ".") (re.range "a" "z")))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.++ (re.+ (re.union (re.range "'" "'")(re.union (re.range "-" "-") (re.range "a" "z")))) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ (re.+ (re.union (re.range "'" "'")(re.union (re.range "-" "-") (re.range "a" "z")))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
