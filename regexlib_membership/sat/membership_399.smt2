;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Password=(?<Password>.*);.*=(?<Info>.*);.*=(?<User>.*);.*=(?<Catalog>.*);.*=(?<Data>.*)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "D\u00CFPassword=~t;=6;\u00F3=;=;=}"
(define-fun Witness1 () String (seq.++ "D" (seq.++ "\xcf" (seq.++ "P" (seq.++ "a" (seq.++ "s" (seq.++ "s" (seq.++ "w" (seq.++ "o" (seq.++ "r" (seq.++ "d" (seq.++ "=" (seq.++ "~" (seq.++ "t" (seq.++ ";" (seq.++ "=" (seq.++ "6" (seq.++ ";" (seq.++ "\xf3" (seq.++ "=" (seq.++ ";" (seq.++ "=" (seq.++ ";" (seq.++ "=" (seq.++ "}" "")))))))))))))))))))))))))
;witness2: "\x10Password=;=;=;52=;=D-"
(define-fun Witness2 () String (seq.++ "\x10" (seq.++ "P" (seq.++ "a" (seq.++ "s" (seq.++ "s" (seq.++ "w" (seq.++ "o" (seq.++ "r" (seq.++ "d" (seq.++ "=" (seq.++ ";" (seq.++ "=" (seq.++ ";" (seq.++ "=" (seq.++ ";" (seq.++ "5" (seq.++ "2" (seq.++ "=" (seq.++ ";" (seq.++ "=" (seq.++ "D" (seq.++ "-" "")))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "P" (seq.++ "a" (seq.++ "s" (seq.++ "s" (seq.++ "w" (seq.++ "o" (seq.++ "r" (seq.++ "d" (seq.++ "=" ""))))))))))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range ";" ";")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range ";" ";")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range ";" ";")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range ";" ";")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "=" "=") (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
