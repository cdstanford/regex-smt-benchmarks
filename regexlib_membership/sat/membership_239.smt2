;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \"[^"]+\"|\([^)]+\)|[^\"\s\()]+
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\"Q\"0t"
(define-fun Witness1 () String (seq.++ "\x22" (seq.++ "Q" (seq.++ "\x22" (seq.++ "0" (seq.++ "t" ""))))))
;witness2: "\"a\xC\"\u0098"
(define-fun Witness2 () String (seq.++ "\x22" (seq.++ "a" (seq.++ "\x0c" (seq.++ "\x22" (seq.++ "\x98" ""))))))

(assert (= regexA (re.union (re.++ (re.range "\x22" "\x22")(re.++ (re.+ (re.union (re.range "\x00" "!") (re.range "#" "\xff"))) (re.range "\x22" "\x22")))(re.union (re.++ (re.range "(" "(")(re.++ (re.+ (re.union (re.range "\x00" "(") (re.range "*" "\xff"))) (re.range ")" ")"))) (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
