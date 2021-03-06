;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-zA-Z]\:)|(\\))(\\{1}|((\\{1})[^\\]([^/:*?<>"|]*))+)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\\"
(define-fun Witness1 () String (seq.++ "\x5c" (seq.++ "\x5c" "")))
;witness2: "n:\"
(define-fun Witness2 () String (seq.++ "n" (seq.++ ":" (seq.++ "\x5c" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range ":" ":")) (re.range "\x5c" "\x5c"))(re.++ (re.union (re.range "\x5c" "\x5c") (re.+ (re.++ (re.range "\x5c" "\x5c")(re.++ (re.union (re.range "\x00" "[") (re.range "]" "\xff")) (re.* (re.union (re.range "\x00" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "{") (re.range "}" "\xff"))))))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
