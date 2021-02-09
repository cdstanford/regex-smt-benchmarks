;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^ \\/:*?""<>|]+([ ]+[^ \\/:*?""<>|]+)*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u008E$    \u00A5\u00A6"
(define-fun Witness1 () String (seq.++ "\x8e" (seq.++ "$" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "\xa5" (seq.++ "\xa6" "")))))))))
;witness2: "\u00F31"
(define-fun Witness2 () String (seq.++ "\xf3" (seq.++ "1" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))))(re.++ (re.* (re.++ (re.+ (re.range " " " ")) (re.+ (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff"))))))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
