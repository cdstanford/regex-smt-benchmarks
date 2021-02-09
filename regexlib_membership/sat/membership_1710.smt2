;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \w?<\s?\/?[^\s>]+(\s+[^"'=]+(=("[^"]*")|('[^\']*')|([^\s"'>]*))?)*\s*\/?>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "8<\u0091\u00A1\u00A0G \u0085 >P"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "<" (seq.++ "\x91" (seq.++ "\xa1" (seq.++ "\xa0" (seq.++ "G" (seq.++ " " (seq.++ "\x85" (seq.++ " " (seq.++ ">" (seq.++ "P" ""))))))))))))
;witness2: "\u00B5<\u0085\x4/>q"
(define-fun Witness2 () String (seq.++ "\xb5" (seq.++ "<" (seq.++ "\x85" (seq.++ "\x04" (seq.++ "/" (seq.++ ">" (seq.++ "q" ""))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "<" "<")(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "=")(re.union (re.range "?" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))))(re.++ (re.* (re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "\x00" "!")(re.union (re.range "#" "&")(re.union (re.range "(" "<") (re.range ">" "\xff"))))) (re.opt (re.union (re.++ (re.range "=" "=") (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.range "\x00" "!") (re.range "#" "\xff"))) (re.range "\x22" "\x22"))))(re.union (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\x00" "&") (re.range "(" "\xff"))) (re.range "'" "'"))) (re.* (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" "&")(re.union (re.range "(" "=")(re.union (re.range "?" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "/" "/")) (re.range ">" ">")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
